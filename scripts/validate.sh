#!/bin/bash
# Multi-Perspective Skill Validator
# Validates skill structure and configuration

set -e

SKILL_DIR="$(dirname "$0")/.."
cd "$SKILL_DIR"

echo "========================================="
echo "Multi-Perspective Skill Validator v1.1.0"
echo "========================================="
echo ""

ERRORS=0
WARNINGS=0

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    ((ERRORS++))
}

warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
    ((WARNINGS++))
}

success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

# Check required files
echo "Checking required files..."

required_files=(
    "SKILL.md"
    "config/settings.yaml"
    "templates/synthesis-prompt.md"
)

for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        success "$file exists"
    else
        error "Missing required file: $file"
    fi
done

# Check agent templates
echo ""
echo "Checking agent templates..."

agents=("architect" "planner" "security" "code-quality" "creative")

for agent in "${agents[@]}"; do
    template="templates/agent-prompts/${agent}.md"
    if [[ -f "$template" ]]; then
        success "$template exists"

        # Check template has required sections
        if ! grep -q "{{USER_REQUEST}}" "$template"; then
            warning "$template missing {{USER_REQUEST}} placeholder"
        fi
    else
        error "Missing agent template: $template"
    fi
done

# Check synthesis template
echo ""
echo "Checking synthesis template..."

synthesis="templates/synthesis-prompt.md"
if [[ -f "$synthesis" ]]; then
    required_placeholders=(
        "{{USER_REQUEST}}"
        "{{ARCHITECT_RESULT}}"
        "{{PLANNER_RESULT}}"
        "{{SECURITY_RESULT}}"
        "{{CODE_QUALITY_RESULT}}"
        "{{CREATIVE_RESULT}}"
    )

    for placeholder in "${required_placeholders[@]}"; do
        if grep -q "$placeholder" "$synthesis"; then
            success "Synthesis has $placeholder"
        else
            warning "Synthesis missing $placeholder"
        fi
    done
fi

# Validate YAML config
echo ""
echo "Checking configuration..."

if [[ -f "config/settings.yaml" ]]; then
    # Check for required keys
    if grep -q "timeout_seconds:" "config/settings.yaml"; then
        success "Config has timeout_seconds"
    else
        error "Config missing timeout_seconds"
    fi

    if grep -q "quorum_minimum:" "config/settings.yaml"; then
        success "Config has quorum_minimum"
    else
        error "Config missing quorum_minimum"
    fi

    if grep -q "version:" "config/settings.yaml"; then
        success "Config has version"
    else
        warning "Config missing version"
    fi
fi

# Check SKILL.md has version
echo ""
echo "Checking SKILL.md metadata..."

if [[ -f "SKILL.md" ]]; then
    if grep -q "^version:" "SKILL.md"; then
        success "SKILL.md has version"
    else
        warning "SKILL.md missing version in frontmatter"
    fi

    if grep -q "quorum" "SKILL.md"; then
        success "SKILL.md documents quorum"
    else
        warning "SKILL.md should document quorum requirements"
    fi

    if grep -q "timeout" "SKILL.md"; then
        success "SKILL.md documents timeout"
    else
        warning "SKILL.md should document timeout"
    fi
fi

# Summary
echo ""
echo "========================================="
echo "Validation Summary"
echo "========================================="
echo -e "Errors:   ${RED}$ERRORS${NC}"
echo -e "Warnings: ${YELLOW}$WARNINGS${NC}"

if [[ $ERRORS -gt 0 ]]; then
    echo ""
    echo -e "${RED}Validation FAILED${NC}"
    exit 1
else
    echo ""
    echo -e "${GREEN}Validation PASSED${NC}"
    exit 0
fi
