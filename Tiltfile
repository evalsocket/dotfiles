
default_registry('docker.io/evalsocket')

load('ext://restart_process', 'docker_build_with_restart')
def initialize(service_list, starting_port=8080):
  for service in service_list:
    files = [service + "/main"]

    docker_build(
      str('evalsocket/'+service), 
      str(service+ '/'),
      dockerfile=str(service+ '/Dockerfile'), 
      live_update=[sync(service + '/bin/' + service , '/bin/')]
      )

initialize(['flyteadmin', 'flytepropeller', 'datacatalog', 'flyteconsole'])

# Set default context
allow_k8s_contexts("k3d-flyte")

# Deploy flyte
k8s_yaml(kustomize('flyte/kustomize/overlays/sandbox/'))

k8s_resource('flyteadmin', port_forwards=8000)