import 'package:flutter/material.dart';

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

  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMore;
  
  final bool isLoading;
  final bool hasMore;
  
  final Widget? emptyWidget;
  final Widget? separatorWidget;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics scrollPhysics;
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

    Widget listView;

    if (widget.separatorWidget != null) {
      listView = ListView.separated(
        controller: _scrollController,
        physics: widget.scrollPhysics,
        scrollDirection: widget.scrollDirection,
        padding: widget.padding,
        itemCount: widget.items.length + (widget.hasMore ? 1 : 0),
        separatorBuilder: (context, index) => widget.separatorWidget!,
        itemBuilder: (context, index) {
          if (index == widget.items.length) {
            return _buildLoadingIndicator();
          }
          return widget.itemBuilder(context, widget.items[index], index);
        },
      );
    } else {
      listView = ListView.builder(
        controller: _scrollController,
        physics: widget.scrollPhysics,
        scrollDirection: widget.scrollDirection,
        padding: widget.padding,
        itemCount: widget.items.length + (widget.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == widget.items.length) {
            return _buildLoadingIndicator();
          }
          return widget.itemBuilder(context, widget.items[index], index);
        },
      );
    }

    if (widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh!,
        child: listView,
      );
    }

    return listView;
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
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
