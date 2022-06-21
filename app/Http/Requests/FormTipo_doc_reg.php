<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
class FormTipo_doc_reg extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            //'tipo_reg_doc'=>'required|max:10',
            'tipo_reg_doc' => [
                'required','max:10', 
                Rule::unique('tipo_doc_reg')
                    ->where('des_t_doc',$this->des_t_doc)
            ],
            'des_t_doc'=>'required|max:45'
        ];
    }
}
