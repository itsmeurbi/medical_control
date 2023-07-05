document.addEventListener("turbo:load", () => {
  const containers = document.querySelectorAll('[data-component="closable"]')
  containers.forEach(container => setupContainer(container))
})

const setupContainer = (container) => {
  const closeButtons = container.querySelectorAll('[data-target="close-btn"]')
  closeButtons.forEach(closeButton => setupCloseButton(closeButton, container))
}

const setupCloseButton = (closeButton, container) => {
  closeButton.addEventListener('click', () => {
    container.classList.toggle('hidden')
  })
}