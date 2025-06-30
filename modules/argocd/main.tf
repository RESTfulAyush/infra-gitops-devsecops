# ───────────────────────────────────────────────────────────
# modules/argocd/main.tf
# ────────────────────────────────────────────────────

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.27"
    }
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.46.6"
  create_namespace = true

  values = [<<-EOT
    server:
      service:
        type: LoadBalancer
      extraArgs:
        - --insecure
      ingress:
        enabled: false
  EOT
  ]
}

# ──────────────────────────────────────────────────
# Optional: Argo CD Application CR
# ─────────────────────────────────────────────────
resource "kubernetes_manifest" "argocd_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"
    metadata = {
      name      = "flipcoin"
      namespace = "argocd"
    }
    spec = {
      project = "default"
      source = {
        repoURL        = "https://github.com/RESTfulAyush/gitops-environments"
        targetRevision = "main"
        path           = "dev/flipcoin"
      }
      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "default"
      }
      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }
      }
    }
  }
}
