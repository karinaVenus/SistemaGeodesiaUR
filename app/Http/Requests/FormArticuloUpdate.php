<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator; //para el validador 
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class FormArticuloUpdate extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'cod_art',
            'des_art'=>'required|max:50', //requerido, max 50
            'cod_cat'=>'required',                     //requerido
            'cod_pres'=>'required',                    //requerido
            'cod_unid_med'=>'required',                //requerido
            //'imagen_art'=>'required|max:200', //requerido, max 200  mimes:jpeg,jpg,png|max:200
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
