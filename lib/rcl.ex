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

    mix_code_str = EEx.eval_string(@mix_tpl_str, tpl_opts)

    vnode_code_str = EEx.eval_string(@vnode_tpl_str, tpl_opts)
    api_code_str = EEx.eval_string(@api_tpl_str, tpl_opts)
    service_code_str = EEx.eval_string(@service_tpl_str, tpl_opts)
    supervisor_code_str = EEx.eval_string(@supervisor_tpl_str, tpl_opts)

    File.write!(Path.join(name, "mix.exs"), mix_code_str)

    File.write!(Path.join(lib_path, "vnode.ex"), vnode_code_str)
    File.write!(Path.join(lib_path, "service.ex"), service_code_str)
    File.write!(Path.join(lib_path, "supervisor.ex"), supervisor_code_str)

    File.write!(Path.join(lib_base_path, "#{name}.ex"), api_code_str)

    File.write!(Path.join(config_path, "config.ex"), @config_config_str)
    File.write!(Path.join(config_path, "dev.ex"), @dev_config_str)
    File.write!(Path.join(config_path, "node1.ex"), @node1_config_str)
    File.write!(Path.join(config_path, "node2.ex"), @node2_config_str)
    File.write!(Path.join(config_path, "node3.ex"), @node3_config_str)
  end

  def run(_other) do
    IO.puts("usage: mix rcl new <project-name>")
  end
end
