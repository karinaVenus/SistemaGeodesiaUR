<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

use Illuminate\Validation\Rule;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class FormTrabajador extends FormRequest
{

    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'cod_t_per'=>'required',
            'nom_per' =>'required',
            'ape_pat_per' =>'required',
            'ape_mat_per' =>'required',
            'cod_t_doc'=>'required',
            'nro_doc'=>'required|unique:persona|size:8',
            'correo_per'=>'required|email|max:45',
            'cod_dist'=>'required',
            'dir_per'=>'required|max:450',
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
