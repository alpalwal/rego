# Native Type: ELB v1
package wiz

default result = "pass"
default ssListenersAndTag = false
default k8sTag = false

ssListenersAndTag {
	input.loadBalancerListeners[i].Listener.InstancePort == 443
	input.loadBalancerListeners[i].Listener.LoadBalancerPort == 443
	input.loadBalancerListeners[i].Listener.InstanceProtocol == "TCP"
	input.loadBalancerListeners[i].Listener.Protocol == "TCP"
}

k8sTag {
	input.loadBalancerTags.KubernetesCluster 
}

result = "fail" {
    not ssListenersAndTag
    not k8sTag
}
