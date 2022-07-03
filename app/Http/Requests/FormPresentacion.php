<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FormPresentacion extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'des_pres'=>'required|unique:presentacion|max:45',//requerido, max 45
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
