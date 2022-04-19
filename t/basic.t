use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

use Test::More 'no_plan';

use POSIX();
use Math::Complex;

use Math::Trig 'pi';


my $BYTE_MAX = 127;
my $BYTE_MIN = -128;
my $SHORT_MAX = 32767;
my $SHORT_MIN = -32768;
my $INT_MAX = 2147483647;
my $INT_MIN = -2147483648;
my $LONG_MAX = 9223372036854775807;
my $LONG_MIN = -9223372036854775808;
my $FLOAT_PRECICE = 16384.5;
my $DOUBLE_PRECICE = 65536.5;

# Positive infinity(unix like system : inf, Windows : 1.#INF)
my $POSITIVE_INFINITY = 9**9**9;

my $NaN = 9**9**9 / 9**9**9;

my $nan_re = qr/(nan|ind)/i;

use SPVM 'TestCase::Math::Complex';



# Start objects count
my $start_memory_blocks_count = SPVM::get_memory_blocks_count();

# PI
{
  ok(SPVM::TestCase::Math::Complex->test_PI);
  if ($] >= 5.022) {
    my $val = eval "0x1.921fb54442d18p+1";
    cmp_ok(SPVM::Math::Complex->PI, '==', $val);
  }
}

# E
{
  ok(SPVM::TestCase::Math::Complex->test_E);
  if ($] >= 5.022) {
    my $val = eval "0x1.5bf0a8b145769p+1";
    cmp_ok(SPVM::Math::Complex->E, '==', $val);
  }
}

# Trigonometric functions
ok(SPVM::TestCase::Math::Complex->test_cos);
ok(SPVM::TestCase::Math::Complex->test_cosf);
ok(SPVM::TestCase::Math::Complex->test_sin);
ok(SPVM::TestCase::Math::Complex->test_sinf);
ok(SPVM::TestCase::Math::Complex->test_tan);
ok(SPVM::TestCase::Math::Complex->test_tanf);
ok(SPVM::TestCase::Math::Complex->test_acos);
ok(SPVM::TestCase::Math::Complex->test_acosf);
ok(SPVM::TestCase::Math::Complex->test_asin);
ok(SPVM::TestCase::Math::Complex->test_asinf);
ok(SPVM::TestCase::Math::Complex->test_atan);
ok(SPVM::TestCase::Math::Complex->test_atanf);

# Hyperbolic functions
ok(SPVM::TestCase::Math::Complex->test_cosh);
ok(SPVM::TestCase::Math::Complex->test_coshf);
ok(SPVM::TestCase::Math::Complex->test_sinh);
ok(SPVM::TestCase::Math::Complex->test_sinhf);
ok(SPVM::TestCase::Math::Complex->test_tanh);
ok(SPVM::TestCase::Math::Complex->test_tanhf);
ok(SPVM::TestCase::Math::Complex->test_acosh);
ok(SPVM::TestCase::Math::Complex->test_acoshf);
ok(SPVM::TestCase::Math::Complex->test_asinh);
ok(SPVM::TestCase::Math::Complex->test_asinhf);
ok(SPVM::TestCase::Math::Complex->test_atanh);
ok(SPVM::TestCase::Math::Complex->test_atanhf);

# Exponential and logarithmic functions
ok(SPVM::TestCase::Math::Complex->test_exp);
ok(SPVM::TestCase::Math::Complex->test_expf);
ok(SPVM::TestCase::Math::Complex->test_exp2);
ok(SPVM::TestCase::Math::Complex->test_exp2f);
ok(SPVM::TestCase::Math::Complex->test_expm1);
ok(SPVM::TestCase::Math::Complex->test_expm1f);
ok(SPVM::TestCase::Math::Complex->test_frexp);
ok(SPVM::TestCase::Math::Complex->test_frexpf);
ok(SPVM::TestCase::Math::Complex->test_ilogb);
ok(SPVM::TestCase::Math::Complex->test_ilogbf);
ok(SPVM::TestCase::Math::Complex->test_ldexp);
ok(SPVM::TestCase::Math::Complex->test_ldexpf);
ok(SPVM::TestCase::Math::Complex->test_log);
ok(SPVM::TestCase::Math::Complex->test_logf);
ok(SPVM::TestCase::Math::Complex->test_log10);
ok(SPVM::TestCase::Math::Complex->test_log10f);
ok(SPVM::TestCase::Math::Complex->test_log1p);
ok(SPVM::TestCase::Math::Complex->test_log1pf);
ok(SPVM::TestCase::Math::Complex->test_log2);
ok(SPVM::TestCase::Math::Complex->test_log2f);
ok(SPVM::TestCase::Math::Complex->test_logb);
ok(SPVM::TestCase::Math::Complex->test_logbf);
ok(SPVM::TestCase::Math::Complex->test_modf);
ok(SPVM::TestCase::Math::Complex->test_modff);
ok(SPVM::TestCase::Math::Complex->test_scalbn);
ok(SPVM::TestCase::Math::Complex->test_scalbnf);
ok(SPVM::TestCase::Math::Complex->test_scalbln);
ok(SPVM::TestCase::Math::Complex->test_scalblnf);

#absolute value functions
{
  ok(SPVM::TestCase::Math::Complex->test_abs);
  ok(SPVM::TestCase::Math::Complex->test_labs);
  ok(SPVM::TestCase::Math::Complex->test_fabs);
  ok(SPVM::TestCase::Math::Complex->test_fabsf);
}

# Power function
ok(SPVM::TestCase::Math::Complex->test_cbrt);
ok(SPVM::TestCase::Math::Complex->test_cbrtf);
ok(SPVM::TestCase::Math::Complex->test_hypot);
ok(SPVM::TestCase::Math::Complex->test_hypotf);
ok(SPVM::TestCase::Math::Complex->test_pow);
ok(SPVM::TestCase::Math::Complex->test_powf);
ok(SPVM::TestCase::Math::Complex->test_sqrt);
ok(SPVM::TestCase::Math::Complex->test_sqrtf);

# Error function and gamma functions
ok(SPVM::TestCase::Math::Complex->test_erf);
ok(SPVM::TestCase::Math::Complex->test_erff);
ok(SPVM::TestCase::Math::Complex->test_erfc);
ok(SPVM::TestCase::Math::Complex->test_erfcf);
ok(SPVM::TestCase::Math::Complex->test_lgamma);
ok(SPVM::TestCase::Math::Complex->test_lgammaf);
ok(SPVM::TestCase::Math::Complex->test_tgamma);
ok(SPVM::TestCase::Math::Complex->test_tgammaf);

# Nearest integer functions
ok(SPVM::TestCase::Math::Complex->test_ceil);
ok(SPVM::TestCase::Math::Complex->test_ceilf);
ok(SPVM::TestCase::Math::Complex->test_floor);
ok(SPVM::TestCase::Math::Complex->test_floorf);
ok(SPVM::TestCase::Math::Complex->test_nearbyint);
ok(SPVM::TestCase::Math::Complex->test_nearbyintf);
ok(SPVM::TestCase::Math::Complex->test_round);
ok(SPVM::TestCase::Math::Complex->test_roundf);
ok(SPVM::TestCase::Math::Complex->test_lround);
ok(SPVM::TestCase::Math::Complex->test_lroundf);
ok(SPVM::TestCase::Math::Complex->test_trunc);
ok(SPVM::TestCase::Math::Complex->test_truncf);

# Surplus functions
ok(SPVM::TestCase::Math::Complex->test_fmod);
ok(SPVM::TestCase::Math::Complex->test_fmodf);
ok(SPVM::TestCase::Math::Complex->test_remainder);
ok(SPVM::TestCase::Math::Complex->test_remainderf);
ok(SPVM::TestCase::Math::Complex->test_remquo);
ok(SPVM::TestCase::Math::Complex->test_remquof);

# Real number operation functions
ok(SPVM::TestCase::Math::Complex->test_copysign);
ok(SPVM::TestCase::Math::Complex->test_copysignf);
ok(SPVM::TestCase::Math::Complex->test_nan);
ok(SPVM::TestCase::Math::Complex->test_nanf);
ok(SPVM::TestCase::Math::Complex->test_nextafter);
ok(SPVM::TestCase::Math::Complex->test_nextafterf);
ok(SPVM::TestCase::Math::Complex->test_nexttoward);
ok(SPVM::TestCase::Math::Complex->test_nexttowardf);

# Maximum, minimum and positive difference functions
ok(SPVM::TestCase::Math::Complex->test_fdim);
ok(SPVM::TestCase::Math::Complex->test_fdimf);
ok(SPVM::TestCase::Math::Complex->test_fmax);
ok(SPVM::TestCase::Math::Complex->test_fmaxf);
ok(SPVM::TestCase::Math::Complex->test_fmin);
ok(SPVM::TestCase::Math::Complex->test_fminf);

# Floating point multiplication and additions
ok(SPVM::TestCase::Math::Complex->test_fma);
ok(SPVM::TestCase::Math::Complex->test_fmaf);

# Classification
ok(SPVM::TestCase::Math::Complex->test_fpclassify);
ok(SPVM::TestCase::Math::Complex->test_fpclassifyf);
ok(SPVM::TestCase::Math::Complex->test_isfinite);
ok(SPVM::TestCase::Math::Complex->test_isfinitef);
ok(SPVM::TestCase::Math::Complex->test_isinf);
ok(SPVM::TestCase::Math::Complex->test_isinff);
ok(SPVM::TestCase::Math::Complex->test_isnan);
ok(SPVM::TestCase::Math::Complex->test_isnanf);
ok(SPVM::TestCase::Math::Complex->test_signbit);
ok(SPVM::TestCase::Math::Complex->test_signbitf);

# Comparison
ok(SPVM::TestCase::Math::Complex->test_isgreater);
ok(SPVM::TestCase::Math::Complex->test_isgreaterf);
ok(SPVM::TestCase::Math::Complex->test_isgreaterequal);
ok(SPVM::TestCase::Math::Complex->test_isgreaterequalf);
ok(SPVM::TestCase::Math::Complex->test_isless);
ok(SPVM::TestCase::Math::Complex->test_islessf);
ok(SPVM::TestCase::Math::Complex->test_islessequal);
ok(SPVM::TestCase::Math::Complex->test_islessequalf);
ok(SPVM::TestCase::Math::Complex->test_islessgreater);
ok(SPVM::TestCase::Math::Complex->test_islessgreaterf);
ok(SPVM::TestCase::Math::Complex->test_isunordered);
ok(SPVM::TestCase::Math::Complex->test_isunorderedf);

# Complex Operations
{
  ok(SPVM::TestCase::Math::Complex->test_complexf);
  ok(SPVM::TestCase::Math::Complex->test_complex);
  ok(SPVM::TestCase::Math::Complex->test_caddf);
  ok(SPVM::TestCase::Math::Complex->test_cadd);
  ok(SPVM::TestCase::Math::Complex->test_csubf);
  ok(SPVM::TestCase::Math::Complex->test_csub);
  ok(SPVM::TestCase::Math::Complex->test_cmulf);
  ok(SPVM::TestCase::Math::Complex->test_cmul);
  ok(SPVM::TestCase::Math::Complex->test_cscamulf);
  ok(SPVM::TestCase::Math::Complex->test_cscamul);
  ok(SPVM::TestCase::Math::Complex->test_cdivf);
  ok(SPVM::TestCase::Math::Complex->test_cdiv);
}

# Complex Functions
{
  ok(SPVM::TestCase::Math::Complex->test_cacos);
  ok(SPVM::TestCase::Math::Complex->test_cacosf);

  ok(SPVM::TestCase::Math::Complex->test_casin);
  ok(SPVM::TestCase::Math::Complex->test_casinf);
  
  ok(SPVM::TestCase::Math::Complex->test_catan);
  ok(SPVM::TestCase::Math::Complex->test_catanf);

  ok(SPVM::TestCase::Math::Complex->test_ccos);
  ok(SPVM::TestCase::Math::Complex->test_ccosf);

  ok(SPVM::TestCase::Math::Complex->test_csin);
  ok(SPVM::TestCase::Math::Complex->test_csinf);

  ok(SPVM::TestCase::Math::Complex->test_ctan);
  ok(SPVM::TestCase::Math::Complex->test_ctanf);

  ok(SPVM::TestCase::Math::Complex->test_cacosh);
  ok(SPVM::TestCase::Math::Complex->test_cacoshf);

  ok(SPVM::TestCase::Math::Complex->test_casinh);
  ok(SPVM::TestCase::Math::Complex->test_casinhf);
  
  ok(SPVM::TestCase::Math::Complex->test_catanh);
  ok(SPVM::TestCase::Math::Complex->test_catanhf);

  ok(SPVM::TestCase::Math::Complex->test_ccosh);
  ok(SPVM::TestCase::Math::Complex->test_ccoshf);

  ok(SPVM::TestCase::Math::Complex->test_csinh);
  ok(SPVM::TestCase::Math::Complex->test_csinhf);

  ok(SPVM::TestCase::Math::Complex->test_ctanh);
  ok(SPVM::TestCase::Math::Complex->test_ctanhf);

  ok(SPVM::TestCase::Math::Complex->test_clog);
  ok(SPVM::TestCase::Math::Complex->test_clogf);

  ok(SPVM::TestCase::Math::Complex->test_cabs);
  ok(SPVM::TestCase::Math::Complex->test_cabsf);

  ok(SPVM::TestCase::Math::Complex->test_carg);
  ok(SPVM::TestCase::Math::Complex->test_cargf);

  ok(SPVM::TestCase::Math::Complex->test_conj);
  ok(SPVM::TestCase::Math::Complex->test_conjf);

  ok(SPVM::TestCase::Math::Complex->test_cexp);
  ok(SPVM::TestCase::Math::Complex->test_cexpf);

  ok(SPVM::TestCase::Math::Complex->test_cpow);
  ok(SPVM::TestCase::Math::Complex->test_cpowf);

  ok(SPVM::TestCase::Math::Complex->test_csqrt);
  ok(SPVM::TestCase::Math::Complex->test_csqrtf);
}

# All object is freed
my $end_memory_blocks_count = SPVM::get_memory_blocks_count();
is($end_memory_blocks_count, $start_memory_blocks_count);

