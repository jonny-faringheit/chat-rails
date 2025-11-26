import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
    this.timeout = null;
    this.searchDelay = 1000; // 1 second delay

    // Close dropdown when clicking outside
    document.addEventListener("click", this.handleOutsideClick.bind(this));
  }

  disconnect() {
    document.removeEventListener("click", this.handleOutsideClick.bind(this));
  }

  handleOutsideClick(event) {
    if (!this.element.contains(event.target)) {
      this.hideResults();
    }
  }

  search() {
    clearTimeout(this.timeout);

    const query = this.inputTarget.value.trim();

    if (query.length === 0) {
      this.hideResults();
      return;
    }

    // Set timeout for 1 second
    this.timeout = setTimeout(() => {
      this.performSearch(query);
    }, this.searchDelay);
  }

  async performSearch(query) {
    try {
      const response = await fetch(
        `/users/search?q=${encodeURIComponent(query)}`,
        {
          headers: {
            Accept: "application/json",
            "X-CSRF-Token": document.querySelector("[name='csrf-token']")
              .content,
          },
        }
      );

      if (!response.ok) throw new Error("Search failed");

      const users = await response.json();
      this.displayResults(users);
    } catch (error) {
      console.error("Search error:", error);
      this.hideResults();
    }
  }

  displayResults(users) {
    if (users.length === 0) {
      this.resultsTarget.innerHTML = `
        <div class="px-4 py-3 text-sm text-gray-500">
          Пользователи не найдены
        </div>
      `;
    } else {
      this.resultsTarget.innerHTML = users
        .map(
          (user) => `
      <a href="/${
        user.login
      }" class="block px-4 py-3 hover:bg-gray-50 transition-colors duration-150">
        <div class="flex items-center space-x-3">
          <div class="shrink-0">
            ${
              user.avatar_url
                ? `<img src="${user.avatar_url}" alt="${user.full_name}" class="w-10 h-10 rounded-full object-cover">`
                : `<div class="w-10 h-10 rounded-full bg-linear-to-br from-orange-400 to-orange-500 flex items-center justify-center text-white font-semibold">
                ${user.first_name.charAt(0).toUpperCase()}
              </div>`
            }
          </div>
          <div class="flex-1 min-w-0">
            <p class="text-sm font-medium text-gray-900 truncate">
              ${user.full_name || user.login}
            </p>
            <p class="text-sm text-gray-500 truncate">
              @${user.login}
            </p>
          </div>
        </div>
      </a>`
        )
        .join("");
    }
    this.showResults();
  }

  showResults() {
    this.resultsTarget.classList.remove("hidden");
  }

  hideResults() {
    this.resultsTarget.classList.add("hidden");
  }
}
