use strict;
use warnings;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use Test::More;
use Test::Trap;

BEGIN { use_ok("App::ClusterSSH::Config") }

my $config;

$config = App::ClusterSSH::Config->new();
isa_ok( $config, 'App::ClusterSSH::Config' );

my $default_config = {
    terminal                   => "xterm",
    terminal_args              => "",
    terminal_title_opt         => "-T",
    terminal_colorize          => 1,
    terminal_bg_style          => 'dark',
    terminal_allow_send_events => "-xrm '*.VT100.allowSendEvents:true'",
    terminal_font              => "6x13",
    terminal_size              => "80x24",

    use_hotkeys             => "yes",
    key_quit                => "Control-q",
    key_addhost             => "Control-Shift-plus",
    key_clientname          => "Alt-n",
    key_history             => "Alt-h",
    key_retilehosts         => "Alt-r",
    key_paste               => "Control-v",
    mouse_paste             => "Button-2",
    auto_quit               => "yes",
    window_tiling           => "yes",
    window_tiling_direction => "right",
    console_position        => "",

    screen_reserve_top    => 0,
    screen_reserve_bottom => 60,
    screen_reserve_left   => 0,
    screen_reserve_right  => 0,

    terminal_reserve_top    => 5,
    terminal_reserve_bottom => 0,
    terminal_reserve_left   => 5,
    terminal_reserve_right  => 0,

    terminal_decoration_height => 10,
    terminal_decoration_width  => 8,

    rsh_args    => "",
    telnet_args => "",
    ssh_args    => "",

    extra_cluster_file => "",

    unmap_on_redraw => "no",

    show_history   => 0,
    history_width  => 40,
    history_height => 10,

    command             => q{},
    max_host_menu_items => 30,

    max_addhost_menu_cluster_items => 6,
    menu_send_autotearoff          => 0,
    menu_host_autotearoff          => 0,

    send_menu_xml_file => $ENV{HOME} . '/.csshrc_send_menu',

    # other bits inheritted from App::ClusterSSH::Base
    debug => 0,
    lang => 'en',

};
is_deeply($config, $default_config, 'default config is correct');

trap {
    $config = $config->validate_args(doesnt_exist => 'whoops');
};
isa_ok($trap->die, 'App::ClusterSSH::Exception::Config');
is($trap->die, 'Unknown configuration parameters: doesnt_exist', 'got correct error message');
is_deeply( $trap->die->unknown_config, ['doesnt_exist'], 'Picked up unknown config array' );





done_testing();
