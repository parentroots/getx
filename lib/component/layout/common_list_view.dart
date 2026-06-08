import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_template/data/models/paginated_response.dart';

/// A premium, highly optimized list view component that supports
/// high-performance lazy rendering, automatic scroll-to-load pagination,
/// pull-to-refresh, custom separators, and empty state fallbacks.
/// 
/// Can run in **Autonomous Mode** (simply pass [onLoadPage] and the widget
/// manages all list data and page states internally) or **Manual Mode** (pass
/// [items], [isLoading], [hasMore], and scroll/refresh callbacks).
class CommonListView<T> extends StatefulWidget {
  const CommonListView({
    super.key,
    this.items = const [],
    required this.itemBuilder,
    this.onRefresh,
    this.onLoadMore,
    this.onLoadPage,
    this.isLoading = false,
    this.hasMore = false,
    this.enablePagination = false,
    this.currentPage,
    this.lastPage,
    this.total,
    this.emptyWidget,
    this.separatorWidget,
    this.padding = const EdgeInsets.all(16.0),
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.scrollDirection = Axis.vertical,
  });

  /// The list of items to render (used in Manual Mode).
  final List<T> items;

  /// Builder function to render each list item.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Optional pull-to-refresh callback (used in Manual Mode).
  final Future<void> Function()? onRefresh;

  /// Optional load-more callback triggered during pagination (used in Manual Mode).
  final Future<void> Function()? onLoadMore;

  /// Page fetching callback (activates **Autonomous Mode**).
  /// Receives the target page index and returns a [PaginatedResponse] containing the items.
  final Future<PaginatedResponse<T>> Function(int page)? onLoadPage;
  
  /// Status showing if a page is currently loading (used in Manual Mode).
  final bool isLoading;

  /// Status showing if there are more items to paginate (used in Manual Mode).
  final bool hasMore;

  /// Manually enable/disable scroll pagination actions (defaults to false, auto-enabled if [onLoadMore]/[onLoadPage] is active).
  final bool enablePagination;

  /// The active paginated page index (used in Manual Mode).
  final int? currentPage;

  /// The total pages index limit (used in Manual Mode).
  final int? lastPage;

  /// The total count of items across all pages.
  final int? total;
  
  /// Custom fallback view when the list is empty.
  final Widget? emptyWidget;

  /// Optional custom divider/separator between items.
  final Widget? separatorWidget;

  /// Padding around the scroll area.
  final EdgeInsetsGeometry padding;

  /// Scroll physics constraint.
  final ScrollPhysics scrollPhysics;

  /// Scroll direction alignment (defaults to vertical).
  final Axis scrollDirection;

  @override
  State<CommonListView<T>> createState() => _CommonListViewState<T>();
}

class _CommonListViewState<T> extends State<CommonListView<T>> {
  final ScrollController _scrollController = ScrollController();

  // Internal states for Autonomous Mode
  final List<T> _internalItems = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _isLoading = false;

  bool get _isAutonomousMode => widget.onLoadPage != null;

  bool get _isPaginationActive =>
      widget.enablePagination ||
      widget.onLoadMore != null ||
      _isAutonomousMode;

  bool get _hasMoreItems {
    if (_isAutonomousMode) {
      return _currentPage < _lastPage;
    }
    if (widget.currentPage != null && widget.lastPage != null) {
      return widget.currentPage! < widget.lastPage!;
    }
    return widget.hasMore;
  }

  bool get _isLoadingState {
    if (_isAutonomousMode) {
      return _isLoading;
    }
    return widget.isLoading;
  }

  List<T> get _displayItems {
    if (_isAutonomousMode) {
      return _internalItems;
    }
    return widget.items;
  }

  @override
  void initState() {
    super.initState();
    if (_isPaginationActive) {
      _scrollController.addListener(_onScroll);
    }
    if (_isAutonomousMode) {
      _loadFirstPage();
    }
  }

  @override
  void didUpdateWidget(covariant CommonListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // Dynamically manage scroll listener on parameter updates
    final oldActive = oldWidget.enablePagination || oldWidget.onLoadMore != null || oldWidget.onLoadPage != null;
    final newActive = _isPaginationActive;
    
    if (newActive != oldActive) {
      if (newActive) {
        _scrollController.addListener(_onScroll);
      } else {
        _scrollController.removeListener(_onScroll);
      }
    }

    if (_isAutonomousMode && oldWidget.onLoadPage != widget.onLoadPage) {
      _loadFirstPage();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadFirstPage() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
      _internalItems.clear();
      _currentPage = 1;
    });

    try {
      final response = await widget.onLoadPage!(1);
      setState(() {
        _internalItems.addAll(response.items);
        _currentPage = response.currentPage;
        _lastPage = response.lastPage;
      });
    } catch (e) {
      debugPrint("CommonListView: Error loading first page: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _loadNextPage() async {
    if (_isLoading || _currentPage >= _lastPage) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final response = await widget.onLoadPage!(nextPage);
      setState(() {
        _internalItems.addAll(response.items);
        _currentPage = response.currentPage;
        _lastPage = response.lastPage;
      });
    } catch (e) {
      debugPrint("CommonListView: Error loading page $_currentPage: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleRefresh() async {
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    } else if (_isAutonomousMode) {
      await _loadFirstPage();
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoadingState && _hasMoreItems) {
        if (_isAutonomousMode) {
          _loadNextPage();
        } else if (widget.onLoadMore != null) {
          widget.onLoadMore!();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final displayList = _displayItems;
    final loading = _isLoadingState;

    // Initial first-page load or empty state routing
    if (displayList.isEmpty) {
      if (loading) {
        return Center(
          child: _buildLoadingIndicator(),
        );
      }
      return widget.emptyWidget ?? _buildDefaultEmptyState(context);
    }

    // High performance lazy delegation of list children
    final sliverList = widget.separatorWidget != null
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final itemIndex = index ~/ 2;
                if (index.isEven) {
                  return widget.itemBuilder(context, displayList[itemIndex], itemIndex);
                }
                return widget.separatorWidget!;
              },
              childCount: displayList.isEmpty ? 0 : displayList.length * 2 - 1,
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => widget.itemBuilder(context, displayList[index], index),
              childCount: displayList.length,
            ),
          );

    // Dynamic high-performance scroll structure
    Widget scrollView = CustomScrollView(
      controller: _scrollController,
      physics: widget.scrollPhysics,
      scrollDirection: widget.scrollDirection,
      slivers: [
        SliverPadding(
          padding: widget.padding,
          sliver: sliverList,
        ),
        if (loading && _hasMoreItems)
          SliverToBoxAdapter(
            child: _buildLoadingIndicator(),
          ),
      ],
    );

    if (widget.onRefresh != null || _isAutonomousMode) {
      return RefreshIndicator(
        onRefresh: _handleRefresh,
        child: scrollView,
      );
    }

    return scrollView;
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: const Center(
        child: SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }

  Widget _buildDefaultEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64.r, color: Colors.grey.shade400),
            SizedBox(height: 16.h),
            Text(
              'No items found',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
