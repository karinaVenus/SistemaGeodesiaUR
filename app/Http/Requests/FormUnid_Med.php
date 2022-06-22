<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator; //para el validador 
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class FormUnid_Med extends FormRequest
{

    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'des_unid_med'=>'required|unique:unid_med|max:45',
            'prefijo_unid_med'=>'required|unique:unid_med|max:10'
        ];
    }
       protected function failedValidation(Validator $validator)
    {
        throw new HttpResponseException(response()->json([
            'errors' => $validator->errors(),
            'status' => true
        ], 422));
    }
}
