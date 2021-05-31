import Vue from 'vue';
import { ValidationObserver, ValidationProvider, extend } from "vee-validate";
import { required, email, min, image } from 'vee-validate/dist/rules';

Vue.component('ValidationProvider', ValidationProvider);
Vue.component('ValidationObserver', ValidationObserver);

// バリデーションルール
extend('required', {
  ...required,
  message: `{_field_}は必須項目です`
});
extend('email', {
  ...email,
  message: "メールアドレスの形式で入力してください"
});
extend('min', {
  ...min,
  message: `{_field_}は3文字以上で入力してください`
});
extend('confirmation', {
   params: ['target'],
   validate(value, { target }) {
    return value === target;
  },
  message: 'パスワードと一致しません'
});
extend('max', {
  validate(value, { length }) {
    return value.length <= length;
  },
  params: ['length'],
  message: `{_field_}は{length}文字以下で入力してください`
});
extend('image', {
  ...image,
  message: '{_field_}は画像形式で入力してください'
});
