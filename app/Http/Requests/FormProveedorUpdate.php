<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator; //para el validador 
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class FormProveedorUpdate extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'cod_t_per'=>'required',
            'razon_social'=>'required|max:45',
            'cod_t_doc'=>'required',
            'nro_doc'=>'required|max:11',
            'correo_per'=>'required|email|max:45',
            'cod_dist'=>'required',
            'dir_per'=>'required|max:450',
            'nro_telf'=>'required|max:9'
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
