class BlocResponse<T> {
  BlocResponseStatus status;
  T data;
  String message;

  BlocResponse.completed(this.data, {this.message})
      : status = BlocResponseStatus.COMPLETED;
  BlocResponse.error(this.message,
      {this.data, this.status = BlocResponseStatus.ERROR});
}

enum BlocResponseStatus { COMPLETED, ERROR, INVALIDATED }
