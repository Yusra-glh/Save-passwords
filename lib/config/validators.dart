class Validators{
  static String? RegisterValidator(String? val,String hintText,{String? oldPassword}){
    if(val!=null){
      if(hintText=="Full name"){
        if(val.isEmpty){
          return "Please enter your name";
        }else
        if (val.length < 2) {
          return "Too short";
        }
        if(!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)){
          return "Use Latin keyboard";
        }
        return null;
      }else if(hintText=="Email Address"){
        if (val.isEmpty) {
          return "Please enter your email address";
        }
        if(!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)){
          return "Use Latin keyboard";
        }
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
          return 'Please enter a valid email !';
        }
        return null;
      }else if(hintText=="Password"){
        if (val.isEmpty) {
          return "Please enter your password";
        }
        if (val.length < 8) {
          return "Weak";
        }
        if(!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)){
          return "Use Latin keyboard";
        }
      }else if(hintText=="Confirm password"){
        if (val.isEmpty) {
          return "Please re-enter your password";
        }
        if(val!=oldPassword){
          return "Please enter a valid password";
        }
        if (val.length < 8) {
          return "Weak";
        }
        if(!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)){
          return "Use Latin keyboard";
        }
      }else if(hintText=="Phone number"){
        if(val.isNotEmpty){
          if(!RegExp("^[\u0000-\u007F]+\$").hasMatch(val)){
            return "Use Latin keyboard";
          }
        }
      }
    }
  }

}
