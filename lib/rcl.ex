defmodule Rcl do
  @vnode_tpl_str File.read!("templates/basic/vnode.ex.tpl")
  @api_tpl_str File.read!("templates/basic/api.ex.tpl")
  @service_tpl_str File.read!("templates/basic/service.ex.tpl")
  @supervisor_tpl_str File.read!("templates/basic/supervisor.ex.tpl")

  def run(["new", name]) do
    # Macro.underscore("HoneyBear")
    module_name = Macro.camelize(name)
    tpl_opts = [name: name, module_name: module_name]
    IO.puts("Creating project #{name}, module #{module_name}")
    Mix.Tasks.New.run([name])
    lib_base_path = Path.join([name, "lib"])
    lib_path = Path.join([name, "lib", name])
    File.mkdir_p!(lib_path)

    vnode_code_str = EEx.eval_string(@vnode_tpl_str, tpl_opts)
    api_code_str = EEx.eval_string(@api_tpl_str, tpl_opts)
    service_code_str = EEx.eval_string(@service_tpl_str, tpl_opts)
    supervisor_code_str = EEx.eval_string(@supervisor_tpl_str, tpl_opts)

    File.write!(Path.join(lib_path, "vnode.ex"), vnode_code_str)
    File.write!(Path.join(lib_path, "service.ex"), service_code_str)
    File.write!(Path.join(lib_path, "supervisor.ex"), supervisor_code_str)
    File.write!(Path.join(lib_base_path, "#{name}.ex"), api_code_str)
  end

  def run(_other) do
    IO.puts("usage: mix rcl new <project-name>")
  end
end
