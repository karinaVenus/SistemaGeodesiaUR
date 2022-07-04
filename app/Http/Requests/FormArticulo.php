<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Http\Exceptions\HttpResponseException;

class FormArticulo extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        return [
            'cod_art'=>'required',
            'des_art'=>'required|max:50', //requerido, max 50
            'cod_cat'=>'required',                     //requerido
            'cod_pres'=>'required',                    //requerido
            'cod_unid_med'=>'required',                //requerido
            //'imagen_art'=>'required|max:200', //requerido, max 200  mimes:jpeg,jpg,png|max:200
            //'cod_estado_art'=>'required'                //requerido
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
