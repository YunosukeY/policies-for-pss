package lib.baseline

import data.lib.k8s
import future.keywords

deny_host_path contains msg if {
	pod := k8s.pod(input)
	some volume in pod.spec.volumes
	volume.hostPath
	msg := sprintf("volume %s in pod %s in %s/%s uses hostPath", [volume.name, pod.metadata.name, input.kind, input.metadata.name])
}
