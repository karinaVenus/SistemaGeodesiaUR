<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator; //para el validador 
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class FormEmpresaUpdate extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            //'cod_t_per'=>'required',
            'razon_social'=>'required|max:45',
            //'cod_t_doc'=>'required',
            'nro_doc'=>'required|max:11',
            'correo_per'=>'required|email|max:45',
            //'logo'=>'required|max:300'
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
