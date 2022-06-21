<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class FormTipo_Transf extends FormRequest
{

    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'des_transf'=>'required|unique:tipo_transf|max:45',//requerido, max 45
        ];
    }
}
