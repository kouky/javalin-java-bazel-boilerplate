# Do not edit. bazel-deps autogenerates this file from.
_JAVA_LIBRARY_TEMPLATE = """
java_library(
  name = "{name}",
  exports = [
      {exports}
  ],
  runtime_deps = [
    {runtime_deps}
  ],
  visibility = [
      "{visibility}"
  ]
)\n"""

_SCALA_IMPORT_TEMPLATE = """
scala_import(
    name = "{name}",
    exports = [
        {exports}
    ],
    jars = [
        {jars}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ]
)
"""

_SCALA_LIBRARY_TEMPLATE = """
scala_library(
    name = "{name}",
    exports = [
        {exports}
    ],
    runtime_deps = [
        {runtime_deps}
    ],
    visibility = [
        "{visibility}"
    ]
)
"""


def _build_external_workspace_from_opts_impl(ctx):
    build_header = ctx.attr.build_header
    separator = ctx.attr.separator
    target_configs = ctx.attr.target_configs

    result_dict = {}
    for key, cfg in target_configs.items():
      build_file_to_target_name = key.split(":")
      build_file = build_file_to_target_name[0]
      target_name = build_file_to_target_name[1]
      if build_file not in result_dict:
        result_dict[build_file] = []
      result_dict[build_file].append(cfg)

    for key, file_entries in result_dict.items():
      build_file_contents = build_header + '\n\n'
      for build_target in file_entries:
        entry_map = {}
        for entry in build_target:
          elements = entry.split(separator)
          build_entry_key = elements[0]
          if elements[1] == "L":
            entry_map[build_entry_key] = [e for e in elements[2::] if len(e) > 0]
          elif elements[1] == "B":
            entry_map[build_entry_key] = (elements[2] == "true" or elements[2] == "True")
          else:
            entry_map[build_entry_key] = elements[2]

        exports_str = ""
        for e in entry_map.get("exports", []):
          exports_str += "\"" + e + "\",\n"

        jars_str = ""
        for e in entry_map.get("jars", []):
          jars_str += "\"" + e + "\",\n"

        runtime_deps_str = ""
        for e in entry_map.get("runtimeDeps", []):
          runtime_deps_str += "\"" + e + "\",\n"

        name = entry_map["name"].split(":")[1]
        if entry_map["lang"] == "java":
            build_file_contents += _JAVA_LIBRARY_TEMPLATE.format(name = name, exports=exports_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "import":
            build_file_contents += _SCALA_IMPORT_TEMPLATE.format(name = name, exports=exports_str, jars=jars_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        elif entry_map["lang"].startswith("scala") and entry_map["kind"] == "library":
            build_file_contents += _SCALA_LIBRARY_TEMPLATE.format(name = name, exports=exports_str, runtime_deps=runtime_deps_str, visibility=entry_map["visibility"])
        else:
            print(entry_map)

      ctx.file(ctx.path(key + "/BUILD"), build_file_contents, False)
    return None

build_external_workspace_from_opts = repository_rule(
    attrs = {
        "target_configs": attr.string_list_dict(mandatory = True),
        "separator": attr.string(mandatory = True),
        "build_header": attr.string(mandatory = True),
    },
    implementation = _build_external_workspace_from_opts_impl
)




def build_header():
 return """"""

def list_target_data_separator():
 return "|||"

def list_target_data():
    return {
"3rdparty/jvm/io/javalin:javalin": ["lang||||||java","name||||||//3rdparty/jvm/io/javalin:javalin","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/io/javalin/javalin|||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_jdk8|||//3rdparty/jvm/org/eclipse/jetty:jetty_server|||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_server|||//3rdparty/jvm/org/eclipse/jetty:jetty_webapp|||//3rdparty/jvm/org/slf4j:slf4j_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/javax/servlet:javax_servlet_api": ["lang||||||java","name||||||//3rdparty/jvm/javax/servlet:javax_servlet_api","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/javax/servlet/javax_servlet_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_client": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_client","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_http|||//3rdparty/jvm/org/eclipse/jetty:jetty_io|||//external:jar/org/eclipse/jetty/jetty_client","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_http": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_http","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_io|||//3rdparty/jvm/org/eclipse/jetty:jetty_util|||//external:jar/org/eclipse/jetty/jetty_http","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_io": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_io","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_util|||//external:jar/org/eclipse/jetty/jetty_io","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_security": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_security","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_server|||//external:jar/org/eclipse/jetty/jetty_security","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_server": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_server","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_http|||//3rdparty/jvm/javax/servlet:javax_servlet_api|||//3rdparty/jvm/org/eclipse/jetty:jetty_io|||//external:jar/org/eclipse/jetty/jetty_server","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_servlet": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_servlet","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_security|||//external:jar/org/eclipse/jetty/jetty_servlet","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_util": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_util","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/eclipse/jetty/jetty_util","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_webapp": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_webapp","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_xml|||//3rdparty/jvm/org/eclipse/jetty:jetty_servlet|||//external:jar/org/eclipse/jetty/jetty_webapp","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty:jetty_xml": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty:jetty_xml","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_util|||//external:jar/org/eclipse/jetty/jetty_xml","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty/websocket:websocket_api": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_api","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/eclipse/jetty/websocket/websocket_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty/websocket:websocket_client": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_client","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_io|||//external:jar/org/eclipse/jetty/websocket/websocket_client|||//3rdparty/jvm/org/eclipse/jetty:jetty_util|||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_common|||//3rdparty/jvm/org/eclipse/jetty:jetty_client|||//3rdparty/jvm/org/eclipse/jetty:jetty_xml","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty/websocket:websocket_common": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_common","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_io|||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_api|||//3rdparty/jvm/org/eclipse/jetty:jetty_util|||//external:jar/org/eclipse/jetty/websocket/websocket_common","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty/websocket:websocket_server": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_server","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty:jetty_http|||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_servlet|||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_common|||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_client|||//external:jar/org/eclipse/jetty/websocket/websocket_server|||//3rdparty/jvm/org/eclipse/jetty:jetty_servlet","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/eclipse/jetty/websocket:websocket_servlet": ["lang||||||java","name||||||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_servlet","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/eclipse/jetty/websocket:websocket_api|||//3rdparty/jvm/javax/servlet:javax_servlet_api|||//external:jar/org/eclipse/jetty/websocket/websocket_servlet","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/jetbrains:annotations": ["lang||||||java","name||||||//3rdparty/jvm/org/jetbrains:annotations","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/jetbrains/annotations","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib": ["lang||||||java","name||||||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_common|||//3rdparty/jvm/org/jetbrains:annotations|||//external:jar/org/jetbrains/kotlin/kotlin_stdlib","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_common": ["lang||||||java","name||||||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_common","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/jetbrains/kotlin/kotlin_stdlib_common","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_jdk7": ["lang||||||java","name||||||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_jdk7","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib|||//external:jar/org/jetbrains/kotlin/kotlin_stdlib_jdk7","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_jdk8": ["lang||||||java","name||||||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_jdk8","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib|||//3rdparty/jvm/org/jetbrains/kotlin:kotlin_stdlib_jdk7|||//external:jar/org/jetbrains/kotlin/kotlin_stdlib_jdk8","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/slf4j:slf4j_api": ["lang||||||java","name||||||//3rdparty/jvm/org/slf4j:slf4j_api","visibility||||||//3rdparty/jvm:__subpackages__","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//external:jar/org/slf4j/slf4j_api","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"],
"3rdparty/jvm/org/slf4j:slf4j_simple": ["lang||||||java","name||||||//3rdparty/jvm/org/slf4j:slf4j_simple","visibility||||||//visibility:public","kind||||||library","deps|||L|||","jars|||L|||","sources|||L|||","exports|||L|||//3rdparty/jvm/org/slf4j:slf4j_api|||//external:jar/org/slf4j/slf4j_simple","runtimeDeps|||L|||","processorClasses|||L|||","generatesApi|||B|||false","licenses|||L|||","generateNeverlink|||B|||false"]
 }


def build_external_workspace(name):
  return build_external_workspace_from_opts(name = name, target_configs = list_target_data(), separator = list_target_data_separator(), build_header = build_header())

