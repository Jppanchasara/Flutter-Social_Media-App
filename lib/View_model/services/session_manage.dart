class SessionContoller{

  static final SessionContoller _session= SessionContoller._internal();


  String? userId;
  
  

  factory SessionContoller(){
    return _session;
  }
  
  SessionContoller._internal(){

  }


}