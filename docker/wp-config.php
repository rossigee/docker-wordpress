<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', getenv("DB_NAME"));

/** MySQL database username */
define('DB_USER', getenv("DB_USER"));

/** MySQL database password */
define('DB_PASSWORD', getenv("DB_PASSWORD"));

/** MySQL hostname */
define('DB_HOST', getenv("DB_HOST"));

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '7CPa7cQ+C,9XZim_GW~n<Kq@=bCih+sFcno!4YNT,+PXl|P|&`S2|:/+`*S=&WI/');
define('SECURE_AUTH_KEY',  'ZQ >hp>|m}x:,P&~9zz`Q%7 ,-EodgyvJL%tXR.qDYtH`q##qNV34<m3(bbHEU,L');
define('LOGGED_IN_KEY',    'RWNLox+^T59 /@Go38wIOycaCq;,JM0 *l*!PHeV)<~&`q!<VwJK`KOAT#<!i2Z)');
define('NONCE_KEY',        '(&my^/Mn{Lv#UUkN}|S$|kLK>t?&+2c=,sss`(AT]T?X@!N$+Dy80;iQe1+j;YQ-');
define('AUTH_SALT',        'RgUTFq-;5JMUTOJ^jOtt+ar5*nHXkYG/pH/|KuB,~m>U(d7+9I+S~c4n2|hn-2u{');
define('SECURE_AUTH_SALT', '|!bbj1*E:`$~2<D+1o65*D@kjf uy|*z2UlGnIM_FE$~s_zdOMRE+`EkKx(wK-*}');
define('LOGGED_IN_SALT',   'V93x:N#fWFdXR)rocwb 6K-T:<nzYZ51t1-Sy?-O|5=&q`+`|18Ni+>38@Q}L4Ed');
define('NONCE_SALT',       'N-R^A<5b ~mk(fpp:EG3O|Wvc GMk3&$ya6Z0zb$Jvv^7/d7&(Q5W^y|*$}(_+&:');
/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
    $_SERVER['HTTPS']='on';

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
