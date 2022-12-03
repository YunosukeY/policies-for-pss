package lib.baseline

import data.lib.k8s
import future.keywords

allowed_capabilities := {
	"AUDIT_WRITE",
	"CHOWN",
	"DAC_OVERRIDE",
	"FOWNER",
	"FSETID",
	"KILL",
	"MKNOD",
	"NET_BIND_SERVICE",
	"SETFCAP",
	"SETGID",
	"SETPCAP",
	"SETUID",
	"SYS_CHROOT",
}

violation_disallowed_capabilities contains msg if {
	not input.metadata.labels.allowPrivilegedLevelCapabilities
	some container in k8s.containers(input)
	some c in container.securityContext.capabilities.add
	not c in allowed_capabilities
	msg := sprintf("baseline level: container %s in %s/%s has disallowed capabilities", [container.name, input.kind, input.metadata.name])
}
