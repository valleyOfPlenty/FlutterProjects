class HttpDelException implements Exception
{
  String message ;
  HttpDelException(this.message) ;

  @override
  String toString() {
    // TODO: implement toString
    return message ;
  }

}
