import 'package:flutter/material.dart';

/// A premium, highly optimized list view component that supports
/// high-performance lazy rendering, automatic scroll-to-load pagination,
/// pull-to-refresh, custom separators, and empty state fallbacks.
class AppListView<T> extends StatefulWidget {
  const AppListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onRefresh,
    this.onLoadMore,
    this.isLoading = false,
    this.hasMore = false,
    this.emptyWidget,
    this.separatorWidget,
    this.padding = const EdgeInsets.all(16.0),
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
    this.scrollDirection = Axis.vertical,
  });

  /// The list of items to render.
  final List<T> items;

  /// Builder function to render each list item.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Optional pull-to-refresh callback.
  final Future<void> Function()? onRefresh;

  /// Optional load-more callback triggered during pagination.
  final Future<void> Function()? onLoadMore;
  
  /// Status showing if a page is currently loading.
  final bool isLoading;

  /// Status showing if there are more items to paginate.
  final bool hasMore;
  
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
  State<AppListView<T>> createState() => _AppListViewState<T>();
}

class _AppListViewState<T> extends State<AppListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.onLoadMore != null) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Triggers loadMore callback when user scrolls within 200px of the bottom limit
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!widget.isLoading && widget.hasMore && widget.onLoadMore != null) {
        widget.onLoadMore!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty && !widget.isLoading) {
      return widget.emptyWidget ?? _buildDefaultEmptyState(context);
    }

    // High performance lazy delegation of list children
    final sliverList = widget.separatorWidget != null
        ? SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final itemIndex = index ~/ 2;
                if (index.isEven) {
                  return widget.itemBuilder(context, widget.items[itemIndex], itemIndex);
                }
                return widget.separatorWidget!;
              },
              childCount: widget.items.isEmpty ? 0 : widget.items.length * 2 - 1,
            ),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => widget.itemBuilder(context, widget.items[index], index),
              childCount: widget.items.length,
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
        if (widget.hasMore)
          SliverToBoxAdapter(
            child: _buildLoadingIndicator(),
          ),
      ],
    );

    if (widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh!,
        child: scrollView,
      );
    }

    return scrollView;
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
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
