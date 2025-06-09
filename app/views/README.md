# Views Structure Documentation

This document describes the organized structure of the views directory for better maintainability and code reuse.

## Directory Structure

```
app/views/
├── shared/                    # Reusable components
│   ├── avatar/               # Avatar-related components
│   │   ├── _display.html.erb          # Basic avatar display
│   │   └── _with_level_badge.html.erb # Avatar with level badge
│   ├── forms/                # Form components
│   │   ├── _input_field.html.erb      # Generic input field
│   │   ├── _section_header.html.erb   # Form section headers
│   │   └── _button.html.erb           # Reusable buttons
│   ├── layout/               # Layout components
│   │   └── _page_container.html.erb   # Standard page wrapper
│   ├── menu/                 # Menu components
│   │   ├── _trigger_button.html.erb   # Menu trigger button
│   │   ├── _user_profile_section.html.erb
│   │   ├── _level_xp_section.html.erb
│   │   ├── _navigation_items.html.erb
│   │   └── _logout_section.html.erb
│   ├── _avatar_upload_script.html.erb # Avatar upload JavaScript
│   ├── _desktop_header.html.erb
│   ├── _mobile_header.html.erb
│   ├── _logo.html.erb
│   ├── _navigation.html.erb
│   └── _user_menu.html.erb
└── users/
    └── registrations/        # User registration views
        ├── _avatar_section.html.erb
        ├── _personal_info_form.html.erb
        ├── _password_section.html.erb
        ├── _current_password_section.html.erb
        ├── _form_actions.html.erb
        ├── _danger_zone.html.erb
        ├── edit.html.erb        # Main edit page
        └── new.html.erb
```

## Component Usage

### Avatar Components

#### Basic Avatar Display
```erb
<%= render "shared/avatar/display", 
    user: current_user, 
    size: "w-16 h-16", 
    editable: true %>
```

#### Avatar with Level Badge
```erb
<%= render "shared/avatar/with_level_badge", 
    user: current_user, 
    size: "w-16 h-16" %>
```

### Form Components

#### Input Field
```erb
<%= render "shared/forms/input_field", 
    form: f, 
    field: :first_name, 
    label: "Name", 
    type: :text, 
    placeholder: "Enter name" %>
```

#### Section Header
```erb
<%= render "shared/forms/section_header", 
    title: "Personal Information", 
    border: true %>
```

#### Button
```erb
<%= render "shared/forms/button", 
    form: f,
    text: "Save", 
    type: "submit", 
    style: "primary" %>
```

### Layout Components

#### Page Container
```erb
<%= render "shared/layout/page_container", 
    title: "Edit Profile" do %>
  <!-- page content -->
<% end %>
```

## Benefits of This Structure

1. **Reusability**: Components can be used across different pages
2. **Maintainability**: Changes to components affect all usage automatically
3. **Consistency**: Ensures UI consistency across the application
4. **Testing**: Easier to test individual components
5. **Documentation**: Clear separation of concerns

## Guidelines

1. **Naming**: Use descriptive names for partials with underscores
2. **Parameters**: Always document required and optional parameters
3. **Flexibility**: Make components configurable with local_assigns
4. **Single Responsibility**: Each partial should have one clear purpose
5. **Documentation**: Add comments explaining component usage

## Migration Notes

All existing functionality has been preserved while improving the code organization. The refactoring maintains backward compatibility and enhances future development efficiency.