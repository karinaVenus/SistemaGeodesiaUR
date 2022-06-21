<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\Validator; //para el validador 
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Http\Exceptions\HttpResponseException;

class FormReg_ing_cabUpdate extends FormRequest
{
    public function authorize()
    {
        return true;
    }
 
    public function rules()
    {
        return [
            'cod_prov'=>'required',
            'cod_trabajador'=>'required',
            'cod_almacen'=>'required',
            'cod_t_transf'=>'required',
            'cod_t_doc'=>'required',
            'nro_doc'=>'required|max:11',
            'fec_doc'=>'required',
            //'cod_estado_reg'=>'required',
            'tot_pagar'=>'required',
            'cod_art'=>'required',
            'prec_unit'=>'required',
            'cant_art'=>'required',
            'prec_compr'=>'required',
            'obs_ing'=>'max:350'
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
