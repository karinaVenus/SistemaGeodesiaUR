<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class FormReg_sal_cab extends FormRequest
{

    public function authorize()
    {
        return true;
    }


    public function rules()
    {
        return [
            'cod_solicitador'=>'required',
            'cod_autorizador'=>'required',
            'cod_almacen'=>'required',
            'cod_t_transf'=>'required',
            'cod_t_doc'=>'required',
            'nro_doc'=>'required|unique:reg_sal_cab|max:11',
            'fec_doc'=>'required',
            //'cod_estado_reg'=>'required',
            //'tot_pagar'=>'required',

            'cod_art'=>'required',
            'cant_art'=>'required',
           // 'prec_sal'=>'required',
            'obs_sal'=>'max:350'
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
