git clone --branch keptn-ocp-0.2.2 https://github.com/peterhack/util
cd util/Bastion
./bastion_setup.sh
./make-k8s-admin.sh
oc adm policy --as system:admin add-cluster-role-to-user cluster-admin admin
oc adm policy  add-cluster-role-to-user cluster-admin system:serviceaccount:default:default
oc adm policy  add-cluster-role-to-user cluster-admin system:serviceaccount:kube-system:default

ssh master.openshift.local /bin/bash <<- EOF
	sudo -i
	cp -n /etc/origin/master/master-config.yaml /etc/origin/master/master-config.yaml.backup
	oc ex config patch /etc/origin/master/master-config.yaml --type=merge -p '{
	  "admissionConfig": {
	    "pluginConfig": {
	      "ValidatingAdmissionWebhook": {
	        "configuration": {
	          "apiVersion": "apiserver.config.k8s.io/v1alpha1",
	          "kind": "WebhookAdmission",
	          "kubeConfigFile": "/dev/null"
	        }
	      },
	      "MutatingAdmissionWebhook": {
	        "configuration": {
	          "apiVersion": "apiserver.config.k8s.io/v1alpha1",
	          "kind": "WebhookAdmission",
	          "kubeConfigFile": "/dev/null"
	        }
	      }
	    }
	  }
	}' >/etc/origin/master/master-config.yaml.patched
	if [ $? == 0 ]; then
	  mv -f /etc/origin/master/master-config.yaml.patched /etc/origin/master/master-config.yaml
	  /usr/local/bin/master-restart api && /usr/local/bin/master-restart controllers
	else
	  exit
	fi
	EOF
