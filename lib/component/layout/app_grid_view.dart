import 'package:flutter/material.dart';

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

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  
  final bool isLoading;
  final bool hasMore;
  
  final Widget? emptyWidget;
  final EdgeInsetsGeometry padding;
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

    Widget gridView = GridView.builder(
      controller: _scrollController,
      physics: widget.scrollPhysics,
      padding: widget.padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.crossAxisCount,
        childAspectRatio: widget.childAspectRatio,
        crossAxisSpacing: widget.crossAxisSpacing,
        mainAxisSpacing: widget.mainAxisSpacing,
      ),
      itemCount: widget.items.length + (widget.hasMore ? widget.crossAxisCount : 0),
      itemBuilder: (context, index) {
        if (index >= widget.items.length) {
          // Show loading indicator at the bottom (centered across the remaining cross-axis space ideally, but simplified here)
          return _buildLoadingIndicator();
        }
        return widget.itemBuilder(context, widget.items[index], index);
      },
    );

    if (widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh!,
        child: gridView,
      );
    }

    return gridView;
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
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
