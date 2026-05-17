import 'package:flutter/material.dart';

/// A premium, highly optimized grid view component that supports
/// high-performance lazy rendering, automatic scroll-to-load pagination,
/// pull-to-refresh, custom empty states, and dynamic sizing parameters.
class AppGridView<T> extends StatefulWidget {
  const AppGridView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 16.0,
    this.mainAxisSpacing = 16.0,
    this.onRefresh,
    this.onLoadMore,
    this.isLoading = false,
    this.hasMore = false,
    this.emptyWidget,
    this.padding = const EdgeInsets.all(16.0),
    this.scrollPhysics = const AlwaysScrollableScrollPhysics(),
  });

  /// The list of items to render.
  final List<T> items;

  /// Builder function to render each grid item.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Number of columns in the grid.
  final int crossAxisCount;

  /// Ratio of cross-axis to main-axis extent.
  final double childAspectRatio;

  /// Spacing between columns.
  final double crossAxisSpacing;

  /// Spacing between rows.
  final double mainAxisSpacing;
  
  /// Optional pull-to-refresh callback.
  final Future<void> Function()? onRefresh;

  /// Optional load-more callback triggered during pagination.
  final Future<void> Function()? onLoadMore;
  
  /// Status showing if a page is currently loading.
  final bool isLoading;

  /// Status showing if there are more items to paginate.
  final bool hasMore;
  
  /// Custom fallback view when the grid is empty.
  final Widget? emptyWidget;

  /// Padding around the scroll area.
  final EdgeInsetsGeometry padding;

  /// Scroll physics constraint.
  final ScrollPhysics scrollPhysics;

  @override
  State<AppGridView<T>> createState() => _AppGridViewState<T>();
}

class _AppGridViewState<T> extends State<AppGridView<T>> {
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

    // Dynamic sliver grid scroll structure
    Widget scrollView = CustomScrollView(
      controller: _scrollController,
      physics: widget.scrollPhysics,
      slivers: [
        SliverPadding(
          padding: widget.padding,
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              childAspectRatio: widget.childAspectRatio,
              crossAxisSpacing: widget.crossAxisSpacing,
              mainAxisSpacing: widget.mainAxisSpacing,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) => widget.itemBuilder(context, widget.items[index], index),
              childCount: widget.items.length,
            ),
          ),
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
            Icon(Icons.grid_view, size: 64, color: Colors.grey.shade400),
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
