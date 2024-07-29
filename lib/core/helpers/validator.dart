mixin Validator {
  String? regExpEmail(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite o e-mail";
    } else {
      if (!RegExp(
              r"^[a-zA-Z0-9]{1}[a-zA-Z0-9.a-zA-Z0-9.\.\-_]+@[a-zA-Z0-9.\.\-_]+\.[a-zA-Z0-9.\.\-_]+$")
          .hasMatch(value!)) {
        return "Email inválido";
      }
      return null;
    }
  }

  String? regExpCelular(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite o celular";
    } else {
      //RegExp codigos de area e telefones brasil
      if (RegExp(
              r"^\((?:[14689][1-9]|2[12478]|3[1234578]|5[1345]|7[134579])\) (9[1-9])[0-9]{3}\-[0-9]{4}$")
          .hasMatch(value!)) {
        return null;
      } else {
        return "Celular inválido";
      }
    }
  }

  String? passwordValidator(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite a senha";
    } else {
      return null;
    }
  }

  String? passwordConfirmation(String? value, {String? valueForComparison}) {
    if (value != null && value.isEmpty) {
      return "Favor digite a confirmação de senha";
    } else if (value == valueForComparison) {
      return null;
    } else {
      return "Confirmação invalida";
    }
  }

  String? nameValidator(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite do nome do usuario";
    } else {
      return null;
    }
  }

  String? userValidator(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite do nome do usuario";
    } else {
      return null;
    }
  }
}
