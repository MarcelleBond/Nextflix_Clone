import 'package:form_field_validator/form_field_validator.dart';

class Validators {
  static var validateName = MultiValidator(
    [
      RequiredValidator(errorText: 'Name is required'),
      MinLengthValidator(3,
          errorText: 'Name must be at least 3 characters long'),
    ],
  );
  
  static var validateEmail = MultiValidator(
    [
      RequiredValidator(errorText: 'Email is required'),
      EmailValidator(errorText: "Invalid email address"),
    ],
  );
  
  static var validatePhoneNumber = MultiValidator(
    [
      RequiredValidator(errorText: 'Phone number is required'),
      MinLengthValidator(10,
          errorText: 'Phone number must be at least 10 digits long'),
           PatternValidator(
        r"^\+?\d+$",
        errorText: "Phone number invalid",
      ),
    ],
  );
  
  static var validatePassword = MultiValidator(
    [
      RequiredValidator(
        errorText: 'Password is required',
      ),
      PatternValidator(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
        errorText: "Password must be at least 8 characters long, include at least one uppercase letter, one lowercase letter, one number, and one special character (@\$!%*?&).",
      ),
    ],
  );
  
  static String? confirmPassword(password, confirmPassword) =>
      MatchValidator(errorText: 'passwords do not match')
          .validateMatch(password, confirmPassword);

  static var validatePrice = MultiValidator(
    [
      RequiredValidator(errorText: 'Please enter the cost of the job.'),
      PatternValidator(
        r'^\d{1,9}(\.\d{1,2})?$',
        errorText: "cost should start with a number",
      ),
    ],
  );

  static RequiredValidator validateRequiredField(String? field) => RequiredValidator(
    errorText: '$field is required',
  );
}
