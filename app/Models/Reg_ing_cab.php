<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reg_ing_cab extends Model
{
    //use HasFactory;
    protected $table = 'reg_ing_cab';
    protected $primaryKey = 'cod_reg_in';
    public $timestamps = false;

    protected $fillable = [
        'cod_prov',
        'cod_trabajador',
        'cod_almacen',
        'cod_t_transf',
        'cod_t_doc',
        'nro_doc',
        'fec_doc',
        'cod_estado_reg',
        'tot_pagar'
    ];

    protected $guarded = [];
}
