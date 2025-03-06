# 07-databricks.zsh
# -------------------------------------------------------------
# Databricks CLI and helper functions.

# Initialize a new bundle from a template
bundleinit() {
    local options="ml\nentity\nsource"
    local selected_template

    selected_template=$(echo "$options" | fzf)
    if [ -n "$selected_template" ]; then
      databricks bundle init \
        https://gitlab.com/b5087/data-platform/bundle-templates \
        --template-dir "templates/$selected_template"
    else
      echo "No template selected."
    fi
}

# Start pipeline
dsp() {
    if [ -z "$1" ]; then
        echo "Usage: dsp <pipeline_id>"
        return 1
    fi
    databricks pipelines start-update "$1"
}

# Pick pipeline, then start or stop it
dgp() {
    local pipeline_id
    pipeline_id=$(
      databricks pipelines list-pipelines \
        | jq -r '.[] | .name + "\t" + .pipeline_id' \
        | xargs printf "%-40s %-40s\n" \
        | fzf \
        | awk -F ' +' '{print $2}'
    )

    if [ -z "$pipeline_id" ]; then
      echo "No pipeline selected."
      return 1
    fi

    local operations=("start" "stop")
    local operation
    operation=$(printf '%s\n' "${operations[@]}" | fzf)

    if [ "$operation" = "start" ]; then
        databricks pipelines start-update "$pipeline_id"
    elif [ "$operation" = "stop" ]; then
        databricks pipelines stop "$pipeline_id"
    else
        echo "Invalid operation selected."
    fi
}

# Get catalogs, schemas, and tables (example skeleton)
dgc() {
    local catalogs=()
    local tables=()

    while read -r catalog; do
        catalogs+=("$catalog")
    done < <(databricks catalogs list | awk '{print $1}' | tail -n +3)

    for catalog in "${catalogs[@]}"; do
        local schemas=()

        while read -r schema; do
            schemas+=("$schema")
        done < <(databricks schemas list "$catalog" | awk '{print $1}' | tail -n +2)

        for schema in "${schemas[@]}"; do
            echo "$schema"
            # Adjust as needed; example approach:
            while read -r table; do
                tables+=("$table")
            done < <(databricks tables list "$catalog" "$schema")
        done
    done

    for table in "${tables[@]}"; do
        echo "$table"
    done
}

