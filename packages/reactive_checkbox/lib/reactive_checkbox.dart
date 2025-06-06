library;

// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [Checkbox] widget in a
/// [ReactiveCheckbox].
///
/// Can optionally provide a [formControl] to bind this widget to a control.
///
/// Can optionally provide a [formControlName] to bind this ReactiveFormField
/// to a [FormControl].
///
/// Must provide one of the arguments [formControl] or a [formControlName],
/// but not both at the same time.
///
/// For documentation about the various parameters, see the [Checkbox] class
/// and [Checkbox], the constructor.
class ReactiveCheckbox<T> extends ReactiveFormField<T, bool> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// The [formControlName] arguments must not be null.
  ReactiveCheckbox({
    super.key,
    super.formControlName,
    super.formControl,
    super.valueAccessor,
    // Map<String, ValidationMessageFunction>? validationMessages,
    // ShowErrorsFunction<T>? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    bool tristate = false,
    Color? activeColor,
    Color? checkColor,
    Color? focusColor,
    Color? hoverColor,
    MouseCursor? mouseCursor,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    bool autofocus = false,
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? overlayColor,
    double? splashRadius,
    FocusNode? focusNode,
    OutlinedBorder? shape,
    BorderSide? side,
    String? semanticLabel,
  }) : super(
          builder: (field) {
            final state = field as _ReactiveCheckboxState<T, bool>;

            state._setFocusNode(focusNode);

            return Checkbox(
              value: tristate ? field.value : field.value ?? false,
              tristate: tristate,
              onChanged: field.control.enabled ? field.didChange : null,
              mouseCursor: mouseCursor,
              activeColor: activeColor,
              checkColor: checkColor,
              focusColor: focusColor,
              hoverColor: hoverColor,
              materialTapTargetSize: materialTapTargetSize,
              visualDensity: visualDensity,
              autofocus: autofocus,
              fillColor: fillColor,
              overlayColor: overlayColor,
              splashRadius: splashRadius,
              focusNode: state.focusNode,
              shape: shape,
              side: side,
              isError: state.control.hasErrors,
              semanticLabel: semanticLabel,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, bool> createState() =>
      _ReactiveCheckboxState<T, bool>();
}

class _ReactiveCheckboxState<T, V> extends ReactiveFormFieldState<T, V> {
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}
