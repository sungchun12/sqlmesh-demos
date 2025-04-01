import typing as t

from sqlmesh.core.linter.rule import Rule, RuleViolation
from sqlmesh.core.model import Model

class NoMissingOwner(Rule): # "nomissingowner" to apply the rule
    """Model owner should always be specified."""

    def check_model(self, model: Model) -> t.Optional[RuleViolation]:
        # Rule violated if the model's owner field (`model.owner`) is not specified
        return self.violation() if not model.owner else None

class NoMissingAudits(Rule): # "nomissingaudits" to apply the rule
    """Model audits should always be specified with at least one audit."""

    def check_model(self, model: Model) -> t.Optional[RuleViolation]:
        # Rule violated if the model's audits field (`model.audits`) is not specified
        return self.violation() if not model.audits else None
