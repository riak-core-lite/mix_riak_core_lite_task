defmodule Rcl do
  @mix_tpl_str File.read!("templates/basic/mix.exs.eex")

  @vnode_tpl_str File.read!("templates/basic/vnode.ex.eex")
  @api_tpl_str File.read!("templates/basic/api.ex.eex")
  @service_tpl_str File.read!("templates/basic/service.ex.eex")
  @supervisor_tpl_str File.read!("templates/basic/supervisor.ex.eex")

  @config_config_str File.read!("templates/basic/config/config.ex")
  @dev_config_str File.read!("templates/basic/config/dev.ex")
  @node1_config_str File.read!("templates/basic/config/node1.ex")
  @node2_config_str File.read!("templates/basic/config/node2.ex")
  @node3_config_str File.read!("templates/basic/config/node3.ex")

  def run(["new", name]) do
    # Macro.underscore("HoneyBear")
    module_name = Macro.camelize(name)
    tpl_opts = [name: name, module_name: module_name]
    IO.puts("Creating project #{name}, module #{module_name}")
    Mix.Tasks.New.run([name])
    lib_base_path = Path.join([name, "lib"])
    lib_path = Path.join([name, "lib", name])
    config_path = Path.join([name, "config"])
    File.mkdir_p!(lib_path)
    File.mkdir_p!(config_path)

    write_template(name, "mix.exs", @mix_tpl_str, tpl_opts)

    write_template(lib_base_path, "#{name}.ex", @api_tpl_str, tpl_opts)

    write_template(lib_path, "vnode.ex", @vnode_tpl_str, tpl_opts)
    write_template(lib_path, "service.ex", @service_tpl_str, tpl_opts)
    write_template(lib_path, "supervisor.ex", @supervisor_tpl_str, tpl_opts)

    write_file(config_path, "config.ex", @config_config_str)
    write_file(config_path, "dev.ex", @dev_config_str)
    write_file(config_path, "node1.ex", @node1_config_str)
    write_file(config_path, "node2.ex", @node2_config_str)
    write_file(config_path, "node3.ex", @node3_config_str)
  end

  def run(_other) do
    IO.puts("usage: mix rcl new <project-name>")
  end

  def write_file(base_dir, file_name, content) do
    file_path = Path.join(base_dir, file_name)

    Mix.Shell.IO.info([IO.ANSI.green(), "rcl: creating", IO.ANSI.default_color(), " #{file_path}"])

    File.write!(file_path, content)
  end

  def write_template(base_dir, file_name, tpl, tpl_opts) do
    content = EEx.eval_string(tpl, tpl_opts)
    write_file(base_dir, file_name, content)
  end
end
