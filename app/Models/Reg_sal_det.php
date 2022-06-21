<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reg_sal_det extends Model
{
    //use HasFactory;
    protected $table = 'reg_sal_det';
    public $timestamps = false;

    protected $fillable = [
        'cod_reg_sal',
        'cod_art',
        'cant_art',
        'prec_sal',
        'obs_sal'
    ];

    protected $guarded = [];
}
