<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reg_sal_cab extends Model
{
    //use HasFactory;
    protected $table = 'reg_sal_cab';
    protected $primaryKey = 'cod_reg_sal';
    public $timestamps = false;

    protected $fillable = [
        'cod_solicitador',
        'cod_autorizador',
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
