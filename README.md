<h1 align="center">Holistic Monorepo</h1>

<p align="center">
  <img height="25" alt="Built with Nix" src="https://img.shields.io/badge/Built%20with-Nix-lightgray?style=for-the-badge&logo=nixos&logoSize=auto&color=%235277C3">
  <img height="25" alt="License: MIT" src="https://img.shields.io/github/license/zabronax/holistic-monorepo?style=for-the-badge&logoSize=auto">
</p>

An experiment into how to structure a holistic monorepo which is self-contained in the broadest sense possible.

> *If it's not in Git, it does not exist.*

It's strongly opinionated regarding reproducability, which is reflected in the technology choices (Nix, OpenTofu, Talos).

> [!IMPORTANT]
>
> This project requires Nix. Reproducibility and environment provisioning rely entirely on it. Compatibility with alternative tooling or non-Nix setups is explicitly out of scope — this is a Nix-first project.

## Motivation

I was exploring how to define, control, and sunset projects in a deterministic way. This repository is an experiment in consolidating that entire lifecycle — from provisioning to decommissioning — into a single version-controlled source of truth.

## Targeted Goal

Have a single Git repository which can be used to bootstrap itself into full deployment based on the most minimal set of inputs. Ideally just a digital wallet/credit, possibly an ID. Pragmatically this will likely be accounts created for different vendors and API tokens added as sealed secrets.

### Final Milestone

Produce a fully reproducible system bootstrap, given only a minimal secret set (e.g., vendor API tokens or wallets), using this single Git repository.

**The following must be achieved:**

- [ ] An online VCS Platform must be bootstrapped and configured from this repository
- [ ] A source artifact from `/sources` is built with Nix, verified, attested, and published
- [ ] A GitOps-managed Kubernetes cluster deploys the artifact via FluxCD
- [ ] A separate management/control plane bootstraps and administers the cluster, fully defined under `/project`
- [ ] A Hook for "draining" the project of persistent data when sunsetting

*All deployments, credentials, policies, and configurations must originate from this repository and be reconstructible deterministically.*

### Stretch Goal

Replace manual procurement of service providers API token with fully programatic acquisition from maximally a wallet and ID. Alternatively setup an OpenStack infrastructure provider solution on Raspberry Pis and use it as service provider (far out of scope, but a possibility).

## Out of scope

This is limited to understanding the limitation of collecting, almost, all required resources for managing a project into a single version controlled repository and how to structure such an endeavor. This means several important aspects are pushed into eventual derivation of this example. Including, but not limited to:

- Performance optimization
- Cost optimization
- Security hardening (beyond basic trust propogation)
- No/Low-code system administration (configuration UIs are a hard no, monitoring UIs are open)
- Rendering/Indexing/Deep Learning of the knowledge directory (might change)

That said. Nix is a functional language, with good compositional properties, and should suffice for a broad set of intent.

## Envisioned Structure

| Status | Top Level Directory       | Imagined Usage                                                           |
|--------|---------------------------|--------------------------------------------------------------------------|
| 🔴     | `/continuous-integration` | Simple flows for handling integration events                             |
| 🔴     | `/deployments`            | (Optional) Defines what's deployed to where (manifests)                  |
| 🔴     | `/knowledge`              | Full ontology and semantic space for the project (ADR, docs, with more)  |
| 🔴     | `/machines`               | Host machine definitions by usecase (Nix flakes, possibly Talos configs) |
| 🟡     | `/project`                | Project lifecycle, managment and external resources IaC definitions      |
| 🔴     | `/sources`                | Flat map of source codes in form of independent Nix flakes               |
| 🔴     | `/tasks`                  | Imperative project management actions                                    |
| 🔴     | `/templates`              | Reusable component bootstrap definitions                                 |

| Sign | Meaning                         |
|------|---------------------------------|
| 🟢   | Implemented                     |
| 🟡   | In progress / partially defined |
| 🔴   | Placeholder or planned          |

## Major Technologies

- **Git**: Primary Change Management tool and base for Nix flake input reference
- **Nix**: Used for dependency management, developer environments, host-machines and replacement for artefact build systems
- **Kubernetes/Talos**: Acts as the cybernetic actuation backbone for reconciling reality with defined state
- **FluxCD**: Keeps the cybernetic system in sync with the source repository
- **OpenTofu**: Provides the DSL for describing initial infrastructure and tooling for realizing it

## Minor Technologies

**Currently Adopted:**
- **SOPS + Age**: Selead secret managment
- **YAML**: Standardisation on configuration format
- **GitHub**: Common version control platform
- **Markdown + Frontmatter**: Standarisation over knowledge encoding with metadata annotation
- **1Password**: Handles external, non-embedded, secrets
- **Nix-direnv**: Automates entering and leaving of directory specific development shells

**Projected Adopted:**
- **Rust**: Used for implementing example sources
- **GitHub Actions**: GitHub's solution for continuous integration and delivery flows
- **S3 compatible object store**: Used for persisting project state data (possible target for decommisioning data)
- **Hetzner**: Choosen as a cheap European cloud vendor
- **Cachix**: Used for caching Nix artefacts
- **Hydra**: Prebuilds Nix artefacts
- **GitHub Container Registry**: Used as OCI compliant registry for cluster deployments
- **Podman**: Used for working with containers locally
