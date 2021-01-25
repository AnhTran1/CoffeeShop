class MResults {
  bool loading;
  bool loaded;
  bool loadFailed;
  bool loadMore;
  String message;
  dynamic data;

  MResults(
      {this.loading,
      this.loaded,
      this.loadFailed,
      this.loadMore,
      this.message,
      this.data});
}
