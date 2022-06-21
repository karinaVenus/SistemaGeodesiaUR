<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tipo_doc_reg extends Model
{
    //use HasFactory;
    protected $table = 'tipo_doc_reg';
    protected $primaryKey = 'cod_t_doc';
    public $timestamps = false;
  
    protected $fillable = [
        'tipo_reg_doc',
        'des_t_doc'
    ];
  
    protected $guarded = [];
}
