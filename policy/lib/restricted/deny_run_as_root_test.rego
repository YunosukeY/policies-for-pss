package lib.restricted

import future.keywords

test_deny_run_as_root if {
	pod := {
		"kind": "Pod",
		"metadata": {"name": "myapp-pod"},
		"spec": {"containers": [
			{
				"name": "myapp",
				"image": "busybox:1.28",
				"command": ["sh", "-c", "echo The app is running! && sleep 3600"],
			},
			{
				"name": "non-root-myapp",
				"image": "busybox:1.28",
				"command": ["sh", "-c", "echo The app is running! && sleep 3600"],
				"securityContext": {"runAsNonRoot": true},
			},
			{
				"name": "root-myapp",
				"image": "busybox:1.28",
				"command": ["sh", "-c", "echo The app is running! && sleep 3600"],
				"securityContext": {"runAsNonRoot": false},
			},
		]},
	}
	deny_run_as_root == {
		"restricted level: pod in Pod/myapp-pod runs as root",
		"restricted level: container myapp in Pod/myapp-pod runs as root",
		"restricted level: container root-myapp in Pod/myapp-pod runs as root",
	} with input as pod
}

test_deny_run_as_root if {
	pod := {
		"kind": "Pod",
		"metadata": {"name": "myapp-pod"},
		"spec": {"securityContext": {"runAsNonRoot": true}},
	}
	count(deny_run_as_root) == 0 with input as pod
}

test_deny_run_as_root if {
	pod := {
		"kind": "Pod",
		"metadata": {"name": "myapp-pod"},
		"spec": {"securityContext": {"runAsNonRoot": false}},
	}
	deny_run_as_root == {"restricted level: pod in Pod/myapp-pod runs as root"} with input as pod
}

test_deny_run_as_root if {
	pod := {
		"kind": "Pod",
		"metadata": {
			"name": "myapp-pod",
			"labels": {"allowRunAsRoot": true},
		},
		"spec": {
			"securityContext": {"runAsNonRoot": false},
			"containers": [{
				"name": "root-myapp",
				"image": "busybox:1.28",
				"command": ["sh", "-c", "echo The app is running! && sleep 3600"],
				"securityContext": {"runAsNonRoot": false},
			}],
		},
	}
	count(deny_run_as_root) == 0 with input as pod
}
