document.addEventListener("turbo:load", () => {
  const containers = document.querySelectorAll('[data-component="closable"]')
  containers.forEach(container => setupContainer(container))
})

const setupContainer = (container) => {
  const closeButtons = container.querySelectorAll('[data-target="close-btn"]')
  closeButtons.forEach(closeButton =>{
    setupCloseButton(closeButton, container)
    setTimeout(() => {
      hideContainer(container)
    }, 5000)
  }
  )
}

const setupCloseButton = (closeButton, container) => {
  closeButton.addEventListener('click', () => {
    hideContainer(container)
  })
}

const hideContainer = (container) => {
  container.classList.toggle('hidden')
}