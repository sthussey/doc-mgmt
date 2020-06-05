# doc-mgmt

A small project to compare and contrast various methods
for managing text-based configuration. In the world of
DevOps and Kubernetes large declarative document sets
are becoming the norm. What is the best method and tooling
for managing these sets to support things like environment
variance, de-duplication, and policy enforcement?

## Kustomize

[kustomize](https://kustomize.io) is a template-free system for creating base and overlay
definitions for Kubernetes resources (I refer to this separation as 'segmented'). It is
Kubernetes specific.

## Helm

[Helm](https://helm.sh) is less a configuration management system and more a "package"
manager for sets of Kubernetes resource definitions. I only include it here because
there are a lot of discussions of 'kustomize vs helm', so I figured it should be 
included for context.

## Cue

[Cue](https://cuelang.org) is both a tool and a language according to their docs. There is
a lot of deeper theory in their documentation, but it is similar to kustomize in that
it is a template-free system creating segmented resource definitions. It includes the
ability to define schemas and policy validation. It is not Kubernetes specific, and in
fact not even YAML specific.

## kpt

[Kuberentes Package Toolkit](https://googlecontainertools.github.io/kpt) is a new
configuration manager for Kubernetes resources. It has similarities to both
Kustomize in that it allows overrides to a base definition and Cue in that it
supports schema validations.

## Mock Project

I'll try to use each of these to build an off-the-shelf Kubernetes deployment
for a mock application containing three microservices. Along with that, we
need to create environment specific configurations for development, test, and
production. Finally, we need a CI test to ensure future configurations meet
certain criteria to avoid security or operational blunders.

###  Lawncare Company

Our mock application will be part of a lawncare company. It will have
three services: customer management, equipment management, weather
monitoring. The first two are stateful and have public APIs. The
weather monitoring service is stateless and is just a backend
utility.

## Environment requirements

Each environment will need to provide small tweaks to the configuration
without redefining the entire deployment

### Development

Only single replicas, use lightweight in-cluster data stores,
no authentication, compute resources must be limited

### Test

Single replicas, prod-like extra-cluster data store, configured
auth, compute resources must be limited

### Production

Multiple replicas, extra-cluster data store, configured
auth

## Policies

Over time various developers and operators might makes changes
to either the basic deployment manifest or one of the environment
definitions. Any of these changes should be validated against
security and operations mandated policies. These two policy
sets are independent and changes to the policies should be
validated against all other sets for compatibility.

### Operations

 * Production must use multiple replicas
 * Test and production must use similar datastore configurations
 * Test and development must have resource limits enabled

### Security

 * Production must have authentication enabled
 * Production must enforce TLS
 * Production must source all images from the internal repo at oci.grass.com
