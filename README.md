# Vera - Swift

Validador de Contraseña y evaluador de fuerza

## Proyecto original

Navajo de Mattt Thompson

## Instalación

Swift Package Manager

Para la integración de la aplicación, debes usar Xcode 12 o superior, para agregar este paquete a tu destino de la aplicación. Para hacer esto, consulta [Agregar dependencias de paquetes](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app?language=objc) a su aplicación sobre el tutorial paso a paso usando Xcode.

## Uso

* Evaluación de la fuerza de la contraseña

Fuerza de la contraseña esta evaluado ein términos de [entropy](https://en.wikipedia.org/wiki/Entropy_%28information_theory%29)

~~~
let password = passwordField.text ?? ""
let strength = Navajo.strength(ofPassword: password) 
strengthLabel.text = Navajo.localizedString(forStrength: strength)
~~~

* Validación de contraseña

~~~
let lengthRule = LengthRule(min: 6, max: 24)
let uppercaseRule = RequiredCharacterRule(preset: .LowercaseCharacter)

validator = PasswordValidator(rules: [lengthRule, uppercaseRule])

if let failingRules = validator.validate(password) {
    validationLabel.textColor = .red
    validationLabel.text = failingRules.map({ return $0.localizedErrorDescription }).joined(separator: "\n")
} else {
    validationLabel.textColor = .green
    validationLabel.text = "Valid"
}
~~~

* Reglas disponibles de validador
1. Allowed Characters
2. Required Characters (custom, lowercase, uppercase, decimal, symbol)
3. Non-Dictionary Word
4. Minimum / Maximum Length
5. Predicate Match
6. Regular Expression Match
7. Block Evaluation

## Contacto

Cualquier feedback y pull request son bienvenidos y muy agradecidos.

Andrés Ocampo
[WebSite](http://www.icologic.co)
OpenSource Software

