describe ('tests add-to-cart feature', () => {
  it('visits homepage', () => {
    cy.visit("http://localhost:3000")
  })

  it('should confirm the count of cart button change when click on the Add button', () => {
    // Get the current cart count before adding products
    cy.get('.nav-link').contains('My Cart').invoke('text').then(text => {
      const initialCartCount = parseInt(text.match(/\d+/)[0])

      // Click the 'Add to Cart' buttons for one of the products
      cy.get('.btn[type="submit"]').first().click({ force: true })

      // Confirm that the cart count increases by 1 after adding products
      cy.get('.nav-link').contains('My Cart').invoke('text').should('contain', initialCartCount + 1)
    });
  })
  
});