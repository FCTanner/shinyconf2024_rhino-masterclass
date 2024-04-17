describe('app', () => {
  beforeEach(() => {
    cy.visit('/');
  });

  it('displays a title', () => {
    // Step 2:
    cy.contains('Rhino App') // will look in entire page
  });

  it('greets user with their name', () => {
    // Step 3:
    cy.get('#app-name')
      .type('Rhino');

    cy.get('#app-greeting') // get greeting output from app, prefix "app-"" can be used to refer by ID; "#" is selector
     .contains('Hello Rhino!');
  });

  it('congratulates for checking all', () => {
    // Step 4:
    cy.get('#app-choices input') // CSS selectors (inputs)
      .check(); // will check ALL, important because number of boxes is random

    cy.get('#app-done')
      .contains('Well done!');
  });
});
