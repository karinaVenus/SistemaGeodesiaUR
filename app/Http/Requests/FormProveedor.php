<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FormProveedor extends FormRequest
{

    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'cod_t_per'=>'required',
            'razon_social'=>'required|unique:persona|max:45',
            'cod_t_doc'=>'required',
            'nro_doc'=>'required|unique:persona|max:11',
            'correo_per'=>'required|email|max:45',
            'cod_dist'=>'required',
            'dir_per'=>'required|max:450',
            //'estado_prov'=>'required',
            'nro_telf'=>'required|array',
            'nro_telf.*'=>'required|between:7,9'// el * especifica que analice cada item del array
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
