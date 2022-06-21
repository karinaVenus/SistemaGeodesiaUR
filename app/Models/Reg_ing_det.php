<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reg_ing_det extends Model
{
    //use HasFactory;
    protected $table = 'reg_ing_det';
    public $timestamps = false;

    protected $fillable = [
        'cod_reg_ing',
        'cod_art',
        'prec_unit',
        'cant_art',
        'prec_compr',
        'obs_ing'
    ];

    protected $guarded = [];
}
